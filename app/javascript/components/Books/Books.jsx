import React, {useState, useEffect} from 'react'
import axios from "axios";
import Book from "./Book";
import './books.scss'

const Books = (props) => {
    const [books, setBooks] = useState([])

    useEffect(() => {
        setBooks(props.books)
    }, [props.books])

    useEffect(() => {
        axios.get('/api/v1/books.json')
            .then((resp) => {
                if (books.length === 0 && $('#search-field').val() === '') {
                    setBooks(resp.data.data)
                }
            })
            .catch((resp) => {
                console.log('Something went wrong...')
                console.log(resp)
            })
    }, [books.length])

    const grid = books.map(item => {
        return (
            <Book key={item.attributes.slug}
                  attributes={item.attributes}
            />
        )
    })

    return (
        <div className={'catalogue'}>
            <h1>Catalogue: </h1>
            <div className="grid">
                {grid}
            </div>
        </div>
    )
}

export default Books
