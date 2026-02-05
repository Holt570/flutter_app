from functools import wraps
import sqlite3
from typing import Any, Dict, Optional

from flask import Flask, jsonify, request

API_KEY = "api_warehouse_student_key_1234567890abcdef"
DB_PATH = "warehouse.db"

app = Flask(__name__)


def get_connection() -> sqlite3.Connection:
    connection = sqlite3.connect(DB_PATH)
    connection.row_factory = sqlite3.Row
    return connection


def row_to_dict(row: sqlite3.Row) -> Dict[str, Any]:
    return dict(row)


def require_api_key(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        header_key = request.headers.get("X-API-Key", "")
        auth_header = request.headers.get("Authorization", "")
        bearer_key = ""
        if auth_header.lower().startswith("bearer "):
            bearer_key = auth_header.split(" ", 1)[1].strip()
        if header_key != API_KEY and bearer_key != API_KEY:
            return jsonify({"error": "Unauthorized"}), 401
        return func(*args, **kwargs)

    return wrapper

@app.route("/", methods=["GET"])
def homePage():
    return "Welcome to the Warehouse Maintenance API!", 200

def fetch_log_by_id(log_id: int) -> Optional[Dict[str, Any]]:
    with get_connection() as connection:
        row = connection.execute(
            """
            SELECT id, title, comment, status, created_at, updated_at
            FROM jobs
            WHERE id = ?
            """,
            (log_id,),
        ).fetchone()
    return row_to_dict(row) if row else None


@app.route("/sync/jobs", methods=["GET"])
@require_api_key
def list_logs():
    with get_connection() as connection:
        rows = connection.execute(
            """
            SELECT id, title, comment, status, created_at, updated_at
            FROM jobs
            ORDER BY id
            """
        ).fetchall()
    return jsonify([row_to_dict(row) for row in rows]), 200


@app.route("/sync/jobs", methods=["POST"])
@require_api_key
def create_log():
    payload = request.get_json(silent=True) or {}
    title = payload.get("title")
    comment = payload.get("comment")
    status = payload.get("status")

    if not all([title, comment, status]):
        return jsonify({"error": "title, comment, and status are required"}), 400

    with get_connection() as connection:
        cursor = connection.execute(
            """
            INSERT INTO jobs
                (title, comment, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            """,
            (title, comment, status),
        )
        log_id = cursor.lastrowid

    return jsonify(fetch_log_by_id(log_id)), 201


@app.route("/sync/jobs/<int:log_id>", methods=["GET"])
@require_api_key
def get_log(log_id: int):
    log = fetch_log_by_id(log_id)
    if not log:
        return jsonify({"error": "log not found"}), 404
    return jsonify(log), 200


@app.route("/sync/jobs/<int:log_id>", methods=["PUT"])
@require_api_key
def update_log(log_id: int):
    payload = request.get_json(silent=True) or {}
    title = payload.get("title")
    comment = payload.get("comment")
    status = payload.get("status")

    if not any([title, comment, status is not None]):
        return jsonify({"error": "no fields to update"}), 400

    updates = []
    values = []

    if title:
        updates.append("title = ?")
        values.append(title)
    if comment:
        updates.append("comment = ?")
        values.append(comment)
    if status:
        updates.append("status = ?")
        values.append(status)

    updates.append("updated_at = CURRENT_TIMESTAMP")

    with get_connection() as connection:
        cursor = connection.execute(
            f"UPDATE jobs SET {', '.join(updates)} WHERE id = ?",
            (*values, log_id),
        )
        if cursor.rowcount == 0:
            return jsonify({"error": "log not found"}), 404

    return jsonify(fetch_log_by_id(log_id)), 200


@app.route("/sync/jobs/<int:log_id>", methods=["DELETE"])
@require_api_key
def delete_log(log_id: int):
    with get_connection() as connection:
        cursor = connection.execute(
            "DELETE FROM jobs WHERE id = ?", (log_id,)
        )
        if cursor.rowcount == 0:
            return jsonify({"error": "log not found"}), 404
    return "", 204


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
