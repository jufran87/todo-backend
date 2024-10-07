REATE OR REPLACE PROCEDURE todo.create_task_prc(
	in_description  IN varchar
)
/*
    PROCEDIMIENTO: todo.create_task_prc
    DESCRIPCIÓN: Inserta una nueva tarea en la tabla todo.tasks con estado 3 que significa 'Pendiente'.
    PARÁMETROS:
        in_description (IN varchar) - La descripción de la tarea a insertar.
    MANEJO DE EXCEPCIONES:
        Si ocurre un error durante la inserción, la transacción se revierte,
        y se registra un mensaje de error en la tabla todo.errors_log con detalles
        sobre el nombre de la tabla ('tasks'), tipo de evento ('INSERT') y el mensaje de error (SQLERRM).
*/
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO todo.tasks(
        description,
        state_id
    ) VALUES (
	    in_description,
        3
    );
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO todo.errors_log(table_name, event_type, log_message) VALUES('tasks', 'INSERT', SQLERRM);
END;
$$;


CREATE OR REPLACE PROCEDURE todo.update_task_prc(
    in_task_id      IN smallint,
    in_description  IN varchar,
    in_stateId      IN smallint
)
/*
    PROCEDIMIENTO: todo.update_task_prc
    DESCRIPCIÓN:
        Este procedimiento actualiza una tarea en la tabla 'todo.tasks' con los valores proporcionados para la descripción y el estado.
    PARÁMETROS:
        - in_task_id (smallint): ID de la tarea que se va a actualizar.
        - in_description (varchar): Nueva descripción de la tarea.
        - in_stateId (smallint): Nuevo ID de estado de la tarea.
    DETALLES:
        El procedimiento realiza una actualización en la tabla 'todo.tasks' estableciendo los nuevos valores para 'description' y 'state_id' 
        'todo.errors_log' con detalles del error.
*/
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE todo.tasks
    SET
        description = in_description,
        state_id = in_stateId
    WHERE
        task_id = in_task_id;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO todo.errors_log(table_name, event_type, log_message) VALUES('tasks', 'UPDATE', SQLERRM);
END;
$$;


CREATE OR REPLACE PROCEDURE todo.delete_task_prc(
    in_task_id      IN smallint
)
/*
    PROCEDIMIENTO: todo.delete_task_prc
    DESCRIPCIÓN: Este procedimiento realiza un borrado lógico de una tarea en la tabla 'todo.tasks' 
                 cambiando el estado de la tarea a 6.
    PARÁMETROS:
      in_task_id (IN smallint): ID de la tarea que se desea borrar lógicamente.
    VARIABLES:
      lnuStateId (smallint): Estado al que se cambiará la tarea para indicar su borrado lógico (valor 6).
    EXCEPCIONES:
      inserta un registro en la tabla 'todo.errors_log' con detalles del error.
*/
LANGUAGE plpgsql
AS $$
DECLARE
    lnuStateId smallint := 6;
BEGIN
    UPDATE todo.tasks
    SET
        state_id = lnuStateId, -- se realiza borrado logico cambiando el estado a 6
        deleted_at = current_timestamp
    WHERE
        task_id = in_task_id;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO todo.errors_log(table_name, event_type, log_message) VALUES('tasks', 'LOGICAL DELETE', SQLERRM);
END;
$$;