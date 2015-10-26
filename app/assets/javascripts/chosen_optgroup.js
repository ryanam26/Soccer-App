$(document).on('click', '.group-result', function() {
    var unselect = $(this).nextUntil('.group-result').not('.result-selected');
    if (unselect.length) {
        unselect.trigger('mouseup');
    } else {
        $(this).nextUntil('.group-result').each(function() {
           $('a.search-choice-close[data-option-array-index="' + $(this).data('option-array-index') + '"]').trigger('click');
        });
    }
});