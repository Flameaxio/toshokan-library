import React, {useEffect, useState} from 'react'
import axios from "axios";
import Book from "../Books/Book";
import '../Books/books.scss'

const Profile = (props) => {
    const [books, setBooks] = useState(props.books)
    const [loaded, setLoaded] = useState(false)

    useEffect(() => {
        setBooks(props.books)
    }, [props.books])

    useEffect(() => {
        axios.get(`/api/v1/books/`, {
            params: {user_id: props.user.id}
        })
            .then((resp) => {
                if (books.length === 0 && $('#search-field').val() === '') {
                    setBooks(resp.data.data)
                }
                setLoaded(true)
            })
            .catch((resp) => {
                console.log('Something went wrong...')
                console.log(resp)
            })
    }, [books.length])
    let grid = '';
    if (loaded) {
        grid = books.map(item => {
            return (
                <Book key={item.attributes.slug}
                      attributes={item.attributes}
                />
            )
        })
    }

    return (
        <div className={'catalogue'}>
            <h1>My books:</h1>
            <div className="grid">
                {grid}
            </div>
        </div>
    )
}

export default Profile