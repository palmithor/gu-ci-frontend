<template>
    <div class='container'>
        <div v-if="isLoading" class="loader"></div>
        <div class="error-text" v-if="getError">Unable to reach backend: {{ getError }}</div>
        <div style='flex: 1;'>
            <div v-if="!getError && !isLoading" class='input__div'>
                <div class='input__wrapper'>
                    <input type='text' placeholder='Things needs to be done.' v-model='todoInput' @keyup.enter='addTodo' />
                </div>
                <div class='border'></div>
            </div>

            <div v-if="!getError && !isLoading" class='todo-list'>
                <!-- Loop Over All Todos -->
                <TodoItem v-for='todo in todoList'
                          :todo="todo"
                          :key='todo.id'
                          class='list'></TodoItem>
            </div>
        </div>
        <footer>
            <span>{{ remaining }} items left.</span>
        </footer>
    </div>
</template>

<script lang='ts'>
import { Component, Vue } from "vue-property-decorator";
import { Todo } from "../Models";
import TodoItem from "./TodoItem.vue";

@Component({
  components: { TodoItem }
})
export default class TodoList extends Vue {
  todoInput = "";

  mounted() {
    this.$store.dispatch("fetchAll");
  }

  addTodo(): void {
    if (this.todoInput.length > 0) {
      this.$store.dispatch("createTodo", this.todoInput);
      this.todoInput = "";
    }
  }

  get todoList(): Todo[] {
    return this.$store.state.todo.list;
  }

  // computed property
  get remaining() {
    return this.$store.getters.getNoneCompleted.length;
  }

  get getError() {
    return this.$store.state.todo.error;
  }

  get isLoading() {
    return this.$store.state.todo.loading;
  }
}
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
<style scoped lang='scss'>
.container {
  min-height: 300px;
  display: flex;
  flex-direction: column;
}

footer {
  padding: 8px 15px;
  background: #b3000c;
  border-radius: 3px;
}

footer span {
  color: white;
}

.error-text {
  color: red;
}

.todo-list {
  padding: 8px 0;
}
.text {
  padding: 0 8px;
  height: 35px;
  line-height: 35px;
  margin: 6px 0;
  cursor: default;
  flex: 1;
}

.todo-list .list:hover {
  background: rgba(205, 0, 14, 0.1);
}

.todo-list .list {
  display: flex;
  align-items: center;
  padding: 0 15px;
}

.input__div .input__wrapper input {
  height: 35px;
  background: 0 0;
  border: 1px solid #b3000c;
  color: #2c3e50;
  display: block;
  font-family: inherit;
  font-size: 16px;
  line-height: 16px;
  outline: 0;
  padding: 5px;
  -webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
  -moz-box-sizing: border-box; /* Firefox, other Gecko */
  box-sizing: border-box; /* Opera/IE 8+ */
  position: relative;
  width: 100%;
  z-index: 1;
}

.input__div .border {
  background: #b3000c;
  transition: all 0.18s;
  bottom: -1px;
  height: 2px;
  left: 30%;
  opacity: 0;
  pointer-events: none;
  position: absolute;
  right: 30%;
}

.input__div:focus-within .border {
  left: 0;
  right: 0;
  opacity: 1;
}

.material-checkbox {
  position: relative;
  display: inline-block;
  color: rgba(0, 0, 0, 0.87);
  cursor: pointer;
  font-size: 14px;
  line-height: 18px;
}

.material-checkbox > input {
  appearance: none;
  -moz-appearance: none;
  -webkit-appearance: none;
  position: absolute;
  z-index: -1;
  left: -5px;
  top: -5px;
  display: block;
  margin: 0;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  background-color: rgba(0, 0, 0, 0.42);
  outline: none;
  opacity: 0;
  transform: scale(1);
  -ms-transform: scale(0); /* Graceful degradation for IE */
  transition: opacity 0.5s, transform 0.5s;
}

.material-checkbox > input:checked {
  background-color: #b3000c;
}

.material-checkbox > input:disabled {
  opacity: 0;
}

.material-checkbox > input:disabled + span {
  cursor: initial;
}

.material-checkbox > span::before {
  content: "";
  display: inline-block;
  margin-right: 15px;
  border: solid 2px rgba(0, 0, 0, 0.42);
  border-radius: 2px;
  width: 14px;
  height: 14px;
  vertical-align: -4px;
  transition: border-color 0.5s, background-color 0.5s;
}

.material-checkbox > input:checked + span::before {
  border-color: #b3000c;
  background-color: #b3000c;
}

.material-checkbox > input:active + span::before {
  border-color: #b3000c;
}

.material-checkbox > input:checked:active + span::before {
  border-color: transparent;
  background-color: rgba(0, 0, 0, 0.42);
}

.material-checkbox > span::after {
  content: "";
  display: inline-block;
  position: absolute;
  top: 0;
  left: 0;
  width: 5px;
  height: 10px;
  border: solid 2px transparent;
  border-left: none;
  border-top: none;
  transform: translate(5.5px, 1px) rotate(45deg);
  -ms-transform: translate(5.5px, 2px) rotate(45deg);
}

.material-checkbox > input:checked + span::after {
  border-color: #fff;
}

.loader {
  border: 16px solid #f3f3f3; /* Light grey */
  border-top: 16px solid #b3000c;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
