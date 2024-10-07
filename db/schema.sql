CREATE SCHEMA todo;

CREATE TABLE todo.states(
	state_id        smallint NOT NULL DEFAULT nextval('todo.seq_states'),
	code            smallint NOT NULL,
	description     varchar(100) NOT NULL,
	created_at      timestamp NOT NULL DEFAULT current_timestamp,
    updated_at      timestamp NOT NULL DEFAULT current_timestamp,
	CONSTRAINT pk_states         PRIMARY KEY (state_id),
	CONSTRAINT un_states_01      UNIQUE (code),
    CONSTRAINT ck_states_code_01 CHECK (code > 99 AND code <= 999)

);

CREATE TABLE todo.tasks(
	task_id         smallint NOT NULL DEFAULT nextval('todo.seq_tasks'),
	description     varchar(100) NOT NULL,
	state_id        smallint NOT NULL,
    created_at      timestamp NOT NULL DEFAULT current_timestamp,
    updated_at      timestamp NOT NULL DEFAULT current_timestamp,
    deleted_at      timestamp DEFAULT NULL,
	CONSTRAINT pk_tasks    PRIMARY KEY (task_id)
);

ALTER TABLE todo.tasks ADD FOREIGN KEY (state_id) REFERENCES todo.states (state_id);