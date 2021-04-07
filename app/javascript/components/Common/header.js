$('document').ready(() => {
    $('.dropdown-toggle').html($('.active').html())
})

$(document).on('click','.dropdown-item',(event) => {
    $('.dropdown-item').removeClass('active');
    $(event.target).addClass('active')
    $('.dropdown-toggle').html($('.active').html())
})