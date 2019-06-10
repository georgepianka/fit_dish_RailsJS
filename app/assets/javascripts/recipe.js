class Recipe {
  constructor(obj) {
     this.id = obj.id
     this.name = obj.name
     this.description = obj.description
     this.instructions = obj.instructions
     this.recipe_ingredients= obj.recipe_ingredients
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
        recipes.map(r => {
          let recipe = new this(r)
          return `<ul> ${recipe.name} <li>${recipe.description}</li><li>${recipe.instructions}</li><li>${recipe.recipe_ingredients}</li></ul>`
        }).join('')
      ).parent()
          .after('<div class="next d-flex-inline mx-2 text-center"><i class="fa fa-chevron-down"></i></div>')
          .before('<div class="prev d-flex-inline mx-2 text-center"><i class="fa fa-chevron-up"></i></div>');

      $("div#dishes-recipe-index").hover(function() {
        $(this).add("div.next, div.prev").stop(true).animate({
          borderWidth: 2
        }, 500)
      }, function() {
        $(this).add("div.next, div.prev").stop(true).animate({
          borderWidth: 1
        }, 500)
      });

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



// ${recipe.ingredientsArray.map(i => `<li> ${i[0]} &nbsp; ${i[1]} </li>`).join(" ")}

  static ready() {
    this.dynamicFields();
    this.toggleRecipeIndex();
  }

}

$(document).on('turbolinks:load', function() {
  Recipe.ready();
})
