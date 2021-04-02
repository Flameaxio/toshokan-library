import React from 'react'
import { BrowserRouter as Link } from "react-router-dom";

const Book = (props) => {
    const genres = props.attributes.genres.map(item => {
        return <Link key={item.slug} to={`/genres/${item.slug}`}>{item.name}</Link>
    })

    const authors = props.attributes.authors.map(item => {
        return <Link key={item.slug} to={`/authors/${item.slug}`}>{item.name}</Link>
    })

    return (
        <a href={`/books/${props.attributes.slug}`}>
            <div className={'card'}>
                <div className="book-cover">
                    <img src={props.attributes.image_url} alt={props.attributes.name}/>
                </div>
                <div className="book-name">{props.attributes.name}</div>
                <div className="card-bottom">
                    <div className="book-genres">{genres}</div>
                    <div className="book-authors">{authors}</div>
                </div>
            </div>
        </a>
    )
}

export default Book