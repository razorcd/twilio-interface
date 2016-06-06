window.addEventListener("DOMContentLoaded", function() {
  ["account_id", "auth_id", "from_number", "to_number", "body"].map(function(name){
    var elements= document.getElementsByName(name);
    for (i in elements) {
      elements[i].onblur = update_similar_elements;
    }
  })

}, false);

function update_similar_elements() {
  console.log(this);
  var name= this.name;
  var similarElements = document.getElementsByName(name);
  for (i in similarElements) {
    similarElements[i].value = this.value;
  }
}
