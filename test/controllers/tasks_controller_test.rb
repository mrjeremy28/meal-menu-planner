require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @task = tasks(:one)
  end
  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end
  test "should get delete" do
    get delete_task_url(@task)
    assert_response :success
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
