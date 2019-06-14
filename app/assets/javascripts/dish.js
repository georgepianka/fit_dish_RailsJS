
class Dish {
  constructor(obj) {
    this.recipeID = obj.recipe.id
    this.name = obj.recipe.name
    this.likeCount = obj.recipe.like_count
    this.currentUserID = obj.recipe.current_user_id
  }

  newDishHTML() {}

  static addToDishes() {
      $("div#dishes-recipe-index").on('click', "a.add-recipe-to-dishes", function(e) {
        e.preventDefault();
        e.stopPropagation();
        console.log($(this).data("current-user-id"))
        let dishData = {dish:{user_id:$(this).data("current-user-id"),recipe_id:$(this).data("recipe-id")}}
        console.log(dishData)

        let action = $("li.nav-item > a#user-dishes-url").attr("href")
        console.log(action)

        $.ajax({
           url: action,
           type: 'POST',
           data: dishData,
           dataType: 'json',
           success: (data) => Dish.addNewDish(data),
           error: (xhr) => Dish.displayErrors(xhr.responseJSON.show_errors)
        });

      });
  }

  static addNewDish(dish) {
    console.log(dish)
    $("div#user-dishes-index")
  }

  static ready() {
    this.addToDishes();
  }


}


$(document).on('turbolinks:load', function() {
    $.ajaxSetup({
        headers:
        { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
    });
    Dish.ready();
})
