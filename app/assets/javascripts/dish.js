
class Dish {
  constructor(obj) {
    this.id = obj.id
    this.recipeID = obj.recipe.id
    this.name = obj.recipe.name
    this.likeCount = obj.recipe.like_count
    this.currentUserID = obj.recipe.current_user_id
  }

  newDishHTML() {
    return `
    <li class="list-group-item">
      <span class="align-middle">${this.name}</span>
      <span class="align-middle ml-2">${this.likeCount > 0 ? this.likeCount : ''}&nbsp;<i class="fas fa-grin-hearts"></i></span>
      <span class="float-right">
      <a class="btn btn-sm btn-primary border border-muted align-middle ml-2" href="/users/${this.currentUserID}/recipes/${this.recipeID}">Recipe Page</a>
      <a class="delete-dish-button btn btn-dark border btn-sm border-muted align-middle" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/users/${this.currentUserID}/dishes/${this.id}">Delete Dish</a>
      </span>
    </li>
    `
  }

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
    !$("div#user-dishes-index > h3").length || $("div#user-dishes-index > h3").replaceWith(
      `<a class="btn btn-dark btn-sm font-weight-bold align-top m-2 mb-3" href="#"><span><i class="fas fa-trash-alt"></i> &nbsp; Delete All Dishes</span></a>`
    );
    $("div#user-dishes-index > ul").append(new this(dish).newDishHTML());
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
