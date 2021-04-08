import React, {useEffect, useState} from 'react'
import axios from "axios";
import Book from "../Books/Book";
import {Link, useParams} from "react-router-dom";
import '../Books/books.scss'

const humanizeString = require('humanize-string');

const Genres = (props) => {
    const slug = useParams().slug
    const [books, setBooks] = useState(props.books)
    const [genre, setGenre] = useState(humanizeString(slug))
    const [loaded, setLoaded] = useState(false)

    useEffect(() => {
        setBooks(props.books)
    }, [props.books])

    useEffect(() => {
        axios.get(`/api/v1/genres/${slug}`)
            .then((resp) => {
                if (props.books.length !== 0) {
                    setBooks(resp.data.data.attributes.books.data)
                }
                setGenre(resp.data.data.attributes.name)
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
            <h1>{genre}:</h1>
            <div className="grid">
                {grid}
            </div>
        </div>
    )
}

export default Genres
