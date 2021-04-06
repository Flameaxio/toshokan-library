import React, {useState, useEffect} from 'react'
import {Link, useParams} from "react-router-dom";
import axios from "axios";

import './book.scss'

const Book = () => {
    const [book, setBook] = useState({})
    const [loaded, setLoaded] = useState(false)
    const slug = useParams().slug;

    useEffect(() => {
        axios.get(`/api/v1/books/${slug}`)
            .then((resp) => {
                setBook(resp.data.data.attributes)
                setLoaded(true)
            })
            .catch((resp) => {
                console.log('Something went wrong...')
                console.log(resp)
            })
    }, [loaded])

    let authors, genres;

    if (loaded) {
        genres = book.genres.map((item, i) => {
            let text = item.name;
            if (book.genres.length !== i + 1) {
                text += ', ';
            }
            return <Link key={item.slug} to={`/genres/${item.slug}`}>{text}</Link>
        })

        authors = book.authors.map((item, i) => {
            let text = item.name;
            if (book.authors.length !== i + 1) {
                text += ', ';
            }
            return <Link key={item.slug} to={`/authors/${item.slug}`}>{text}</Link>
        })
    }
    return (
        <>
            <div className="top">
                <div className="cover">
                    <img src={book.image_url} alt=""/>
                    <div className="genres">Genres: {genres}</div>
                    <div className="authors">Genres: {authors}</div>
                </div>
                <div className="about">
                    <h1 className="title">{book.name}</h1>
                    <div className="description">{book.description}</div>
                </div>
                <div className="buy">
                    <button className={'btn btn-success'}>Buy</button>
                </div>
            </div>
            <div className="main-wrapper">
                <div className="bottom">
                    <div className="reviews">
                        <h1>Reviews: </h1>
                    </div>
                </div>
            </div>
        </>
    )
}

export default Book
