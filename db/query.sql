-- query.sql

-- name: Callcreate_task_prc :exec
CALL todo.create_task_prc($1);

-- name: Callupdate_task_prc :exec
CALL todo.update_task_prc($1, $2, $3);

-- name: Calldelete_task_prc :exec
CALL todo.delete_task_prc($1);

-- name: GetTask :one
SELECT * FROM todo.tasks WHERE task_id = $1 and state_id != 6 LIMIT 1;

-- name: ListLastTasks :many
SELECT a.* FROM (SELECT ord.* FROM todo.tasks ord where ord.state_id != 6 ORDER BY ord.created_at DESC) a LIMIT 10;

-- name: ListAllTasks :many
SELECT * FROM todo.tasks where state_id != 6 ORDER BY created_at DESC;

-- name: ListOpenTask :many
SELECT * FROM todo.tasks where state_id = 3 ORDER BY created_at DESC;

-- name: ListClosedTask :many
SELECT * FROM todo.tasks where state_id = 5 ORDER BY created_at DESC;