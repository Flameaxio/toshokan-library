import React from 'react'
import {Link} from "react-router-dom"
import './books.scss'

const Book = (props) => {
    const genres = props.attributes.genres.map((item, i) => {
        let text = item.name;
        if (props.attributes.genres.length !== i + 1) {
            text += ', ';
        }
        return <Link key={item.slug} to={`/genres/${item.slug}`}>{text}</Link>
    })

    const authors = props.attributes.authors.map((item, i) => {
        let text = item.name;
        if (props.attributes.authors.length !== i + 1) {
            text += ', ';
        }
        return <Link key={item.slug} to={`/authors/${item.slug}`}>{text}</Link>
    })

    return (
        <div className={'card'}>
            <Link to={`/books/${props.attributes.slug}`}>
                <div className="book-cover">
                    <img src={props.attributes.image_url} alt={props.attributes.name}/>
                </div>
            </Link>
            <div className="book-name"><Link to={`/books/${props.attributes.slug}`}>{props.attributes.name}</Link></div>
            <div className="card-bottom">
                <div className="book-genres"><p>Genres: {genres}</p></div>
                <div className="book-authors"><p>Authors: {authors}</p></div>
            </div>
        </div>
    )
}

export default Book