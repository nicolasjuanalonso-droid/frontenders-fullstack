# blueprints\edit.py
# Edita um único registro (pad)

import sqlite3
from flask import Blueprint, flash, redirect, render_template, request, url_for
from database import DB_NAME

edit_bp = Blueprint('edit', __name__)


@edit_bp.route("/edit/<int:pad_id>", methods=["GET", "POST"])
def edit_page(pad_id):

    owner_uid = request.cookies.get('owner_uid')
    if owner_uid is None:
        return redirect(url_for('home.home_page'))

    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    cursor.execute('''
        SELECT pad_id, pad_title, pad_content, pad_owner FROM pads
        WHERE pad_id = ? AND pad_status = 'ON'
    ''', (pad_id,))

    row = cursor.fetchone()

    if row is None:
        conn.close()
        return redirect(url_for('home.home_page'))

    if row['pad_owner'] != owner_uid:
        conn.close()
        return redirect(url_for('home.home_page'))

    if request.method == "POST":
        new_title = request.form.get("padtitle", "").strip() 
        new_content = request.form.get("padcontent", "").strip()

        cursor.execute(
            'UPDATE pads SET pad_title = ?, pad_content = ? WHERE pad_id = ?',
            (new_title, new_content, pad_id,)
        )

        conn.commit()
        conn.close()

        flash("Alterações salvas com sucesso!", "success")
        return redirect(url_for("view.view_page", pad_id=pad_id))

    conn.close()
    return render_template("edit.html", pad=row)