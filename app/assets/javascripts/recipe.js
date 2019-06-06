class Recipe {
 constructor(obj) {
     this.id = obj.id
     this.name = obj.name
     this.description = obj.description
     this.instructions = obj.instructions
     this.ingredientsArray = obj.recipe_ingredients.map(i => [i.quantity, i.ingredient.name])
     }





  static dynamicFields() {

    $('form#recipe_form').on('click', '#remove_ingredient', function(e) {
      e.preventDefault();
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('tr').hide();
    });

    $('form#recipe_form').on('click', '#add_fields', function(e) {
      e.preventDefault();
      let time = new Date().getTime();
      let regExpForChildIndex = new RegExp($(this).data('id'), 'g');
      $('#fields').append($(this).data('fields-to-add').replace(regExpForChildIndex, time));
    });

  }

  static toggleRecipeIndex() {

    $("a#toggle-dishes-recipe-index").click( function(e) {
      e.preventDefault();
      $(this).html(
        $(this).html() == '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>' ? '<span><i class="far fa-minus-square"></i> &nbsp; Hide All Recipes</span>' : '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>'
      )
      $('div#dishes-recipe-index').toggle();


        $.ajax({
           url: this.href,
           type: 'GET',
           dataType: 'json',
           success: (data) => Recipe.displayRecipeIndex(data),
           error: (xhr) => Recipe.displayErrors(xhr.responseJSON.show_errors)
        });

    });
  }

  static displayErrors(show_errors) {
      console.log(show_errors)
  }

  static displayRecipeIndex(recipes) {
      $("div#dishes-recipe-index").html(
        recipes.map(r => {
        let recipe = new this(r)
        return `<ul> ${r.name}:  ${r.ingredientsArray.forEach(i => `<li> ${i[0]} &nbsp; ${i[1]} </li>`)}</ul>`
        }).join('')
      );
  }

  static ready() {
    this.dynamicFields();
    this.toggleRecipeIndex();
  }

}

$(document).on('turbolinks:load', function() {
  Recipe.ready();
})
