class Substitution {

 constructor(obj) {
 }
}


  Substitution.getSubstitutionForm = () => {
    $('#recommend-substitution').click(function (e) {
      e.preventDefault();
      const url = this.href
      console.log(url);
      $.getJSON(url, response => {
        console.log(response.form_data);
        Substitution.displaySubstitutionForm(response.form_data);
      });
    })
  }

  Substitution.displaySubstitutionForm = formData => {
    Substitution.formHTML = formData;
    $("#new-substitution-form").html(formData);
    Substitution.newSubstitution();
  }

  Substitution.newSubstitution = () => {
    $("div#new-substitution-form form").on('submit', function(e) {
      e.preventDefault();
      let formData = $(this).serialize();
      console.log(this.attributes.action.value)
      let action = this.attributes.action.value

      $.ajax({
         url: action,
         type: 'POST',
         data: formData,
         dataType: 'json',
         success: (data) => Substitution.updateSubstitutions(data),
         error: (xhr) => Substitution.displayErrors(xhr.responseJSON.show_errors)
      });
    });
  }

  Substitution.updateSubstitutions = data => {
    $("div#new-substitution-form").html(JSON.stringify(data));
    console.log(data)
  }

  Substitution.displayErrors = show_errors => {
    console.log(show_errors)
    const errorMessages = `<div id="error-messages" class="text-center text-danger m-2"> <h4>Please Try Again!</h4> ${show_errors} </div>`;
    $("div#new-substitution-form").children("#error-messages").empty();
    $("div#new-substitution-form").prepend(errorMessages);
    $('form input[value="Recommend Substitution!"]').prop("disabled", false);

  }


  Substitution.ready = function() {
    this.getSubstitutionForm()
  }


$(document).on('turbolinks:load', function() {
  Substitution.ready();
})

/*


function updatePage(response) {
  $("div#container").html(" ");
  let thisTrip = new Trip(response);
  let newTrip = thisTrip.tripHTML();
  console.log(response)
  $("div#container").append(newTrip);
}

class  {
  constructor(obj) {
    this.id = obj.id;
    this.name = obj.name;
    this.length = obj.length;
    this.transportation = obj.transportation;
    this.hotel_info = obj.hotel_info;
    this.packing_list = obj.packing_list;
    this.attractions = obj.attractions;
    this.visited  = obj.visited;
    this.year_visited = obj.year_visited;
  }
}

.prototype.tripHTML = function () {
  return (`<h1>Trip Name: ${this.name}</h1>
  <p>Trip ID: ${this.id}</p>
  <p>Length: ${this.length}</p>
  <p>Transportation: ${this.transportation}</p>
  <p>Packing: ${this.packing_list}</p>
  <p>Accommodation: ${this.hotel_info}</p>
  <p>Year Visited: ${this.year_visited}</p>
  <p>Attractions: ${this.attractions}</p> `)
  }




*/
