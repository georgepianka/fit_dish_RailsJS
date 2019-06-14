class Recipe {
  constructor(obj) {
     this.id = obj.id
     this.name = obj.name
     this.description = obj.description
     this.instructions = obj.instructions
     this.likeCount = obj.like_count
     this.currentUserID = obj.current_user_id
     this.recipeIngredients = obj.recipe_ingredients

     }

  indexHTML() {
    return `
      <li class="recipe-index-item list-group-item hvr-grow px-0">
        <span class="float-left align-middle mt-1"><span class="btn btn-sm recipe-index-item-menu-icon"><i class="fas fa-chevron-circle-down"></i></span>${this.name}</span>
        <a class="add-recipe-to-dishes btn btn-outline-dark btn-sm float-right mr-1" data-recipe-id="${this.id}" data-current-user-id="${this.currentUserID}" href="#"><span><i class="fas fa-plus"></i></span></a>
        <a class="recipe-page-button btn btn-sm btn-primary border border-muted mr-2 float-right" href="/users/${this.currentUserID}/recipes/${this.id}">Recipe Page</a>
        <span class="float-right mx-2 mt-1">
        ${this.likeCount > 0 ? this.likeCount : ''}&nbsp;<i class="fas fa-grin-hearts"></i>
        </span></br>
      </li>
    `
  }

  recipeDetailsHTML() {
    return `
    </br><div class="dishes-recipe-info h6 mx-3">
    <u>Description</u>
    <p>${this.description}</p>
    <u>Instructions</u>
    <p>${this.instructions}</p>
    <u>Ingredients</u>
    <table class="table">
        ${this.recipeIngredients.map(r =>
            `<tr><td><i>${r.quantity}</i></td><span class="float-right"><td><b>${r.ingredient.name}</b></td></span></tr>`
        ).join('')}
      </table>
      </div>
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

      this.recipeIndexHoverBorder();
      this.recipeIndexHoverScroll();
      this.showRecipeInfo();
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

  static showRecipeInfo() {
      $("div#dishes-recipe-index").on('click', "li.recipe-index-item", function(e) {
        $(this).find("span.recipe-index-item-menu-icon").html(
          $(this).find("span.recipe-index-item-menu-icon").html() == '<i class="fas fa-chevron-circle-down"></i>' ? '<i class="fas fa-chevron-circle-up"></i>' : '<i class="fas fa-chevron-circle-down"></i>'
        );

        if(!$(this).children('div.dishes-recipe-info').length){
          let action = $(this).find("a.recipe-page-button").attr("href")
          $.ajax({
            url: action,
            type: 'GET',
            dataType: 'json',
            success: (data) => $(this).append(new Recipe(data).recipeDetailsHTML()),
            error: (xhr) => Recipe.displayErrors(xhr.responseJSON.show_errors)
          });
        }else{
          $(this).children('div.dishes-recipe-info').toggle();
        }
      });
  }

  static ready() {
      this.dynamicFields();
      this.toggleRecipeIndex();
  }

}

$(document).on('turbolinks:load', function() {
  Recipe.ready();
})
