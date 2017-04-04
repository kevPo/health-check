Vue.http.interceptors.push({
  request: function (request) {
    Vue.http.headers.common['X-CSRF-Token'] = $('[name="csrf-token"]').attr('content');
    return request;
  },
  response: function(response) {
    return response;
  }
});
categoryResource = Vue.resource('/categories{/id}.json')
let Events = new Vue({});
Vue.component('category', {
  props: ['categories', 'category'],
  data() {
    return {
      editMode: false,
      originalCategory: {}
    };
  },
  template: `
      <div class="category-container" @click="edit" v-bind:class="{ 'edit-mode': editMode }">
        <div class="card">
          <div v-if="editMode">
            <a @click="showDeletePopup" class="delete is-medium"></a>
          </div>
          <div class="title">
            <input v-if="editMode" type="text" class="form-title" v-model="category.name">
            <h3 v-else>{{ category.name }}</h3>
          </div>
          <div class="example">
            <h4>Example of awesome</h4>
            <textarea v-if="editMode" class="form-area" v-model="category.awesome"></textarea>
            <p v-else>{{ category.awesome }}</p>
          </div>
          <div class="example">
            <h4>Example of crappy</h4>
            <textarea v-if="editMode" class="form-area" v-model="category.crappy"></textarea>
            <p v-else>{{ category.crappy }}</p>
          </div>
          <div v-if="editMode" class="form-buttons">
            <button @click="cancel" class="btn-cancel">Cancel</button>
            <button @click="save" class="btn-save">Save</button>
          </div>
        </div>
      </div>
    `,
    mounted() {
      this.originalCategory.name = this.category.name;
      this.originalCategory.awesome = this.category.awesome;
      this.originalCategory.crappy = this.category.crappy;
      this.editMode = false;
    },
    methods: {
      edit(e) {
        if (!this.editMode && !e.target.classList.contains('btn-cancel') && !e.target.classList.contains('btn-save') && !e.target.classList.contains('delete'))
          this.editMode = true;
      },
      cancel() {
        this.category.name = this.originalCategory.name;
        this.category.awesome = this.originalCategory.awesome;
        this.category.crappy = this.originalCategory.crappy;
        this.editMode = false;
      },
      save() {
        // save it
        this.originalCategory = this.category;
        // show success
        this.editMode = false;
      },
      showDeletePopup() {
        Events.$emit('showDeletePopup', this.category);
        this.editMode = false;
      }
    }
});
Vue.component('delete-popup', {
  props: ['category', 'deleteCategory'],
  template: `
    <div id="delete_popup">
      <h3>Are you sure you want to delete {{ category.name }}?</h3>
      <div class="large-form-buttons">
        <button class="btn-cancel delete_popup_close">Cancel</button>
        <button @click="deleteCategory(category)" class="btn-remove">Delete</button>
      </div>
    </div>
  `
});
Vue.component('create-popup', {
  props: ['categories'],
  data() {
    return {
      categoryToAdd: {
        name: '',
        awesome: '',
        crappy: ''
      }
    };
  },
  template: `
    <div id="create_popup" style="display:none">
      <div class="card">
        <div class="large-form-title">
          <input id="categoryTitle" v-model="categoryToAdd.name" type="text" name="" value="" placeholder="Category Title">
        </div>
        <div class="example">
          <h3>Example of awesome</h3>
          <textarea name="" v-model="categoryToAdd.awesome" class="large-form-area"></textarea>
        </div>
        <div class="example">
          <h3>Example of crappy</h3>
          <textarea name="" v-model="categoryToAdd.crappy" class="large-form-area"></textarea>
        </div>
        <div class="large-form-buttons">
          <button class="btn-cancel create_popup_close">Cancel</button>
          <button @click="create">Create</button>
        </div>
      </div>
    </div>
  `,
  methods: {
    create() {
      let category = {
        name: this.categoryToAdd.name,
        awesome: this.categoryToAdd.awesome,
        crappy: this.categoryToAdd.crappy
      };
      categoryResource.save({category: category}).then(
        (response) => {
          this.categoryToAdd = {};
          this.categories.push(response.data);
          this.categories.sort((categoryA, categoryB) => { return categoryA.name > categoryB.name ? 1 : -1; });
          $('#create_popup').popup('hide');
        },
        (response) => {
          this.errors = response.data.errors
          console.log(this.errors);
        });
    }
  }
});
categories = new Vue({
  el: '#categories',
  data: {
    categories: [],
    category: {},
    categoryToDelete: {
      name: '',
      id: ''
    },
    errors: {}
  },
  mounted() {
    let that = this;
    categoryResource.get().then(
      function (response) {
        that.categories = response.data;
      });
    let popupOptions = {
       color: '#ccc',
       opacity: 1,
       transition: '0.3s',
       scrolllock: true,
       blur: false,
       focuselement: '#categoryTitle'
    };
    $('#create_popup').popup(popupOptions);
    $('#delete_popup').popup(popupOptions);
    Events.$on('showDeletePopup', (category) => {
      this.categoryToDelete = category;
      $('#delete_popup').popup('show');
    });
    Events.$on('categoryRemoved', (id) => {
      that.categories = that.categories.filter(c => c.id !== id);
    });
  },
  methods: {
    showCreatePopup() {
      $('#create_popup').popup('show');
    },
    deleteCategory(category) {
      let idOfCategory = category.id;
      categoryResource.delete({id: idOfCategory}).then(
        (response) => {
          var index = this.categories.findIndex((c) => { return c.id === idOfCategory });
          this.categories.splice(index, 1);
          $('#delete_popup').popup('hide');
        });
    }
  }
});