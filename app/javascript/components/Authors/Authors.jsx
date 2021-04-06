import React, {useEffect, useState} from 'react'
import axios from "axios";
import Book from "../Books/Book";
import {useParams} from "react-router-dom";
import '../Books/books.scss'
const humanizeString = require('humanize-string');

const Authors = () =>{
    const slug = useParams().slug
    let words = humanizeString(slug).split(" ");
    for (let i = 0; i < words.length; i++) {
        words[i] = words[i][0].toUpperCase() + words[i].substr(1);
    }
    const name = words.join(' ')
    const [books, setBooks] = useState([])
    const [author, setAuthor] = useState(name)
    const [loaded, setLoaded] = useState(false)
    useEffect(() => {
        axios.get(`/api/v1/authors/${slug}`)
            .then((resp) => {
                setBooks(resp.data.data.attributes.books.data)
                setAuthor(resp.data.data.attributes.name)
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
            <h1>{author}:</h1>
            <div className="grid">
                {grid}
            </div>
        </div>
    )
}

export default Authors
