import React, {useState, useEffect} from "react";
import axios from "axios";
import consumer from "../../channels/consumer"


const Feedback = (props) => {
    const [hidden, setHidden] = useState(true)
    const [rotation, setRotation] = useState(180)
    const [messages, setMessages] = useState([])
    const [content, setContent] = useState('')
    const [loaded, setLoaded] = useState(false)

    useEffect(() => {
        if (!loaded) {
            axios.get('/api/v1/messages').then((resp) => {
                setMessages(resp.data.messages.reverse())
                setLoaded(true)
            }).catch(err => {
                console.log(err)
            })
        }
    }, [loaded])

    consumer.subscriptions.create("ChatChannel", {
        connected() {
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            if (messages.filter(e => e.id + '' === data.id+'').length === 0 && props.user.id+'' === data.chat_user_id+'') {
                const newMessages = messages.reverse();
                newMessages.push(data);
                setMessages(newMessages.reverse())
                setContent('')
            }
        }
    });

    const handleClick = (e) => {
        const value = hidden ? 0 : -550
        setRotation(rotation + 180)
        $('.feedback').css({
            'bottom': `${value}px`
        });
        $('.fa-angle-double-up').css({'transform': 'rotate(' + rotation + 'deg)'});
        setHidden(!hidden)
    }

    const messagesRender = messages.map((item) => {
        const own = item.user_id === props.user.id ? 'message-own' : ''
        return <div key={item.id} className={`message ${own}`}>{item.content}</div>
    })

    const handleChange = (event) => {
        setContent(event.target.value)
    }

    const handleSubmit = (event) => {
        event.preventDefault();
        axios.post('/api/v1/messages', {
            message: {
                content: content,
            }
        }, {withCredentials: true}).then()
    }

    return (
        <div className={'feedback'}>
            <div className="notch" onClick={handleClick}>
                <i className="fas fa-angle-double-up"/> Feedback
            </div>
            <div className="messages-wrapper">
                {messagesRender}
            </div>
            <form onSubmit={handleSubmit} className={'message-form'}>
                <input value={content} onChange={handleChange} id="text-message" type="text" placeholder="Type your message here ..."/>
                <button type="submit">Send</button>
            </form>
        </div>
    )
}

export default Feedback
