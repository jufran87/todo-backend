package db

import (
	"context"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestCreateTask(t *testing.T) {
	err := testQueries.Callcreate_task_prc(context.Background(), "Test Task")
	require.NoError(t, err)
}

// prueba actualizando una tarea a estado 5
func TestUpdateTask(t *testing.T) {
	err := testQueries.Callupdate_task_prc(context.Background(), Callupdate_task_prcParams{
		UpdateTaskPrc:   41,
		UpdateTaskPrc_2: "Updated Task",
		UpdateTaskPrc_3: 5,
	})

	require.NoError(t, err)
}

// prueba eliminando una tarea
func TestDeleteTask(t *testing.T) {
	err := testQueries.Calldelete_task_prc(context.Background(), 41)
	require.NoError(t, err)
}

func TestGetTask(t *testing.T) {
	task, err := testQueries.GetTask(context.Background(), 41)
	require.NoError(t, err)
	require.NotEmpty(t, task)
}

func TestListLastTasks(t *testing.T) {
	tasks, err := testQueries.ListLastTasks(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, tasks)
}

func TestListAllTasks(t *testing.T) {
	tasks, err := testQueries.ListAllTasks(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, tasks)
}

func TestListOpenTask(t *testing.T) {
	tasks, err := testQueries.ListOpenTask(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, tasks)
}

func TestListClosedTask(t *testing.T) {
	tasks, err := testQueries.ListClosedTask(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, tasks)
}
