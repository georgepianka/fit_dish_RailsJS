module RecipesHelper

  #Method that generates html string for new Form Row within Dataset Property inside a Link.

  #Generates a render recipe_ingredients partial, passing the builder, which ends up rendering the HTML for an entire Recipe Form Entry.

  #JS Event Handler attached to form and triggered by clicking link replaces the child-index with a timestamp, ensuring unique fields, then appends the HTML to the form.

  #Delete Link Both hides designated form row AND changes value of :_destroy hidden_field from 0/false to 1/true so entries can be deleted in Edit View.
end
