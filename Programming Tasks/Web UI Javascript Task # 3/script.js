let tasks = JSON.parse(localStorage.getItem('tasks')) || [];

function renderTasks() {
  const list = document.getElementById('taskList');
  const search = document.getElementById('searchInput').value.toLowerCase();
  list.innerHTML = '';

  tasks.forEach((task, index) => {
    if (task.toLowerCase().includes(search)) {
      const li = document.createElement('li');
      const span = document.createElement('span');
      span.textContent = task;

      const editBtn = document.createElement('button');
      editBtn.textContent = 'Edit';
      editBtn.onclick = () => editTask(index);

      const delBtn = document.createElement('button');
      delBtn.textContent = 'X';
      delBtn.onclick = () => deleteTask(index);

      li.appendChild(span);
      li.appendChild(editBtn);
      li.appendChild(delBtn);
      list.appendChild(li);
    }
  });
}

function addTask() {
  const taskInput = document.getElementById('taskInput');
  const task = taskInput.value.trim();
  if (task) {
    tasks.push(task);
    updateStorage();
    taskInput.value = '';
    renderTasks();
  }
}

function editTask(index) {
  const newTask = prompt('Edit your task', tasks[index]);
  if (newTask !== null && newTask.trim() !== '') {
    tasks[index] = newTask.trim();
    updateStorage();
    renderTasks();
  }
}

function deleteTask(index) {
  tasks.splice(index, 1);
  updateStorage();
  renderTasks();
}

function clearAll() {
  if (confirm('Clear all tasks?')) {
    tasks = [];
    updateStorage();
    renderTasks();
  }
}

function updateStorage() {
  localStorage.setItem('tasks', JSON.stringify(tasks));
}

document.getElementById('searchInput').addEventListener('input', renderTasks);
window.onload = renderTasks;
