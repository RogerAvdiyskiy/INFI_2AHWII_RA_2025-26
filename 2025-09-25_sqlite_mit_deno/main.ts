import { DatabaseSync } from "node:sqlite";

const db = new DatabaseSync("2ahwii.db");
const stmt = db.prepare("SELECT * FROM students");
const rows = stmt.all();
console.log(rows);
