@chosenify = (entry) ->
  entry.chosen
    allow_single_deselect: true
    no_results_text: "Ничего не найдено:"
    placeholder_text_single: "Выберите из списка"
    placeholder_text_multiple: "Выберите несколько из списка"
$ ->
  
  chosenify $(".chosen")

  $("form.formtastic .inputs").click ->
    $(".chosen").chosen
      allow_single_deselect: true
      no_results_text: "Ничего не найдено"
      placeholder_text_single: "Выберите из списка"
      placeholder_text_multiple: "Выберите несколько из списка"
