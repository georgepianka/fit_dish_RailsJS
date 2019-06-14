class Recipe {
  constructor(obj) {
     this.id = obj.id
     this.name = obj.name
     this.description = obj.description
     this.instructions = obj.instructions
     this.like_count = obj.like_count
     this.user_id = obj.user_id
     this.recipe_ingredients= obj.recipe_ingredients

     }

  indexHTML() {
    return `
      <li id="recipe-index-item" class="list-group-item hvr-grow px-0">
        <span class="float-left align-middle mt-1"><span class="btn btn-sm"><i class="fas fa-chevron-circle-down"></i></span>${this.name}</span>
        <a class="btn btn-outline-dark btn-sm float-right" href="#"><span><i class="fas fa-plus"></i></span></a>
        <a id="add-recipe-to-dishes" class="btn btn-sm btn-primary border border-muted mr-2 float-right" href="/users/${this.user_id}/recipes/${this.id}">Recipe Page</a>
        <span class="float-right mr-2 mt-1">
        ${this.like_count > 0 ? this.like_count : ''}&nbsp;<i class="fas fa-grin-hearts"></i>
        </span>
      </li>
    `
  }

  //Dynamic Fields for Recipe Form
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

  //RecipeIndex on User Dishes Page
  static toggleRecipeIndex() {

    $("a#toggle-dishes-recipe-index").click( function(e) {
      e.preventDefault();
      $(this).html(
        $(this).html() == '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>' ? '<span><i class="far fa-minus-square"></i> &nbsp; Hide All Recipes</span>' : '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>'
      );

      if($('#dishes-recipe-index-wrapper').is(':empty')){
         $.ajax({
           url: this.href,
           type: 'GET',
           dataType: 'json',
           success: (data) => Recipe.displayRecipeIndex(data),
           error: (xhr) => Recipe.displayErrors(xhr.responseJSON.show_errors)
         })
       };

       $('div#dishes-recipe-index').add("div.next, div.prev").toggle();

    });
  }

  static displayErrors(show_errors) {
      console.log(show_errors)
  }

  static displayRecipeIndex(recipes) {

      $("div#dishes-recipe-index-wrapper").html(
        `<ul class="list-group my-0 mx-0">
        ${recipes.map(r => new this(r).indexHTML()).join('')}
        </ul`
      ).parent()
          .after('<div class="next d-flex-inline mx-2 text-center"><i class="fa fa-chevron-down"></i></div>')
          .before('<div class="prev d-flex-inline mx-2 text-center"><i class="fa fa-chevron-up"></i></div>');

      Recipe.recipeIndexHoverBorder();
      Recipe.recipeIndexHoverScroll();
      Recipe.getRecipeInfo();
  }

  static recipeIndexHoverBorder() {
      $("div#dishes-recipe-index").hover(function() {
        $(this).add("div.next, div.prev").stop(true).animate({
          borderWidth: 2
        }, 500)
      }, function() {
        $(this).add("div.next, div.prev").stop(true).animate({
          borderWidth: 1
        }, 500)
      });
  }

  static recipeIndexHoverScroll() {

      $("div.next").hover(function() {
        $("div#dishes-recipe-index").stop(true).animate({
          "scrollTop": $("div#dishes-recipe-index-wrapper").height()
        }, 15000);
      }, function() {
        $("div#dishes-recipe-index").stop(true)
      });

      $("div.prev").hover(function() {
        $("div#dishes-recipe-index").stop(true).animate({
          "scrollTop": 0
        }, 15000);
      }, function() {
        $("div#dishes-recipe-index").stop(true)
      });
  }

  static getRecipeInfo() {
      $("div#dishes-recipe-index").on('click', "li#recipe-index-item", function(e) {
          e.preventDefault();
          let action = $(this).find("a#add-recipe-to-dishes").href
          $.ajax({
            url: action,
            type: 'GET',
            dataType: 'json',
            success: (data) => Recipe.displayRecipeInfo(data),
            error: (xhr) => Recipe.displayErrors(xhr.responseJSON.show_errors)
          });
      });
  }

  static displayRecipeInfo(recipe) {
    let recipe_info = new this(recipe)
    console.log(JSON.parse(recipe))
  }

  static ready() {
      this.dynamicFields();
      this.toggleRecipeIndex();
  }

}

$(document).on('turbolinks:load', function() {
  Recipe.ready();
})
