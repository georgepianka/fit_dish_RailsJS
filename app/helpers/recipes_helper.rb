module RecipesHelper

  #Method that generates html string for new Form Row within Dataset Property inside a Link.

  #Generates a render recipe_ingredients partial, passing the builder, which ends up rendering the HTML for an entire Recipe Form Entry.

  #JS Event Handler attached to form and triggered by clicking link replaces the child-index with a timestamp, ensuring unique fields, then appends the HTML to the form.

  #Delete Link Both hides designated form row AND changes value of :_destroy hidden_field from 0/false to 1/true so entries can be deleted in Edit View.

  def button_add_row(name, f, association, nested_association = nil, **args)

    new_recipe_ingredient = f.object.send(association).build
    if nested_association
      new_recipe_ingredient.send("build_#{nested_association}")
    end
    id = new_recipe_ingredient.object_id
    #going to have to replace later, since this id will be the same each time button is clicked... it's only
    #set once when form is rendered...

    fields_to_add = f.fields_for(association, new_recipe_ingredient, child_index: id) do |builder|
    #need to output render recipe_ingredient partial, but passing the same builder..
    #f.fields_for(arguments) is generating same builder...
      render(association.to_s.singularize, f: builder)
    end

    link_to(('<i class="fas fa-plus"></i> &nbsp'+ name).html_safe, '#', id: "add_fields", class: args[:class], data: {id: id, fields_to_add: fields_to_add.gsub("/n", "")})
  end

end
