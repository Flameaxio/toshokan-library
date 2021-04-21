import consumer from "../../channels/consumer";
import axios from "axios";

//const url = location.protocol + '//' + window.location.hostname.split('.')[window.location.hostname.split('.').length-2]+'.'+window.location.hostname.split('.')[window.location.hostname.split('.').length-1];
const location = window.location.href.toString()
const chat_id_string = location.substring(location.lastIndexOf('/') + 1).replaceAll('[?]', '')
const chat_id = parseInt(chat_id_string)

$(document).ready(() => {
    $('.message-form').on('submit', (e) => {
        e.preventDefault();

        let current_user;
        axios.get('/api/v1/users/logged_in', {withCredentials: true}).then(response => {
            if (response.data.logged_in) {
                current_user = response.data.user
                axios.post('/api/v1/messages', {
                    message: {
                        content: $('#text-message').val(),
                    },
                    chat_id: chat_id,
                    user_id: current_user.id
                }, {withCredentials: true}).then(() => {
                    $('#text-message').val('')
                })
            }
        }).catch(error => {
            console.log(error)
        })
    })
})

consumer.subscriptions.create("ChatChannel", {
    connected() {
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        console.log(data)
        let current_user;
        axios.get('/api/v1/users/logged_in', {withCredentials: true}).then(response => {
            if (response.data.logged_in && data.chat_id+'' === chat_id+'') {
                current_user = response.data.user
                let message = data;
                let string = `<div class="message ${message.user_id+'' === current_user.id+'' ? 'message-own' : ''}">${message.content}</div>`
                $('.messages-wrapper').prepend(string)
            }
        }).catch(error => {
            console.log(error)
        })
    }
});