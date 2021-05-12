import React, {useState, useEffect} from 'react'
import {Link, useParams} from "react-router-dom";
import axios from "axios";


const Book = (props) => {
    const checkOwnership = (book_slug) => {
        axios.get(`/api/v1/books/${book_slug}/check_ownership`, {
            params: {
                slug: slug
            }
        }).then((response) => {
            setOwnership(response.data.ownership === 'YES')
        }).catch(() => {
            setOwnership(false)
        })
    }

    const [book, setBook] = useState({})
    const [loaded, setLoaded] = useState(false)
    const slug = useParams().slug;
    const [ownership, setOwnership] = useState(false)
    const [message, setMessage] = useState('')
    useEffect(() => {
        axios.get(`/api/v1/books/${slug}`)
            .then((resp) => {
                setBook(resp.data.data.attributes)
                checkOwnership(slug)
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

    const handleClick = () => {
        if (props.loggedInStatus === 'LOGGED_IN') {
            axios.post(`/api/v1/books/${slug}/buy`, {slug: slug}).then((response) => {
                let style = {color: 'red'}
                if ('' + response.data.status === '' + 200) {
                    setOwnership(true)
                    style = {color: 'green'}
                }
                let mes = <span style={style}>{response.data.message}</span>
                setMessage(mes)
            })
        } else {
            props.history.push('/sign_in')
        }
    }

    let button;
    if (props.loggedInStatus === 'LOGGED_IN') {
        if (ownership) {
            button = (<Link to={`${slug}/read/`} className={'btn btn-success read-btn'}>Read</Link>)
        } else {
            button = (<button onClick={handleClick}
                              className={'btn btn-success'}>{'Buy'}</button>)
        }
    } else {
        button = (
            <button style={{fontSize: 24 + 'px'}} onClick={handleClick} className={'btn btn-success'}>Sign in</button>)
    }

    return (
        <>
            <div className="top">
                <div className="cover">
                    <img src={book.image_url} alt=""/>
                    <div className="genres">Genres: {genres}</div>
                    <div className="authors">Authors: {authors}</div>
                </div>
                <div className="about">
                    <h1 className="title">{book.name}</h1>
                    <div className="description">{book.description}</div>
                </div>
                <div className="buy">
                    {message}
                    {button}
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
