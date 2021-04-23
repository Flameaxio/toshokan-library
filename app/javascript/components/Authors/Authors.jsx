import React, {useEffect, useState} from 'react'
import axios from "axios";
import Book from "../Books/Book";
import {useParams} from "react-router-dom";
import '../Books/books.scss'
import {Pagination} from "semantic-ui-react";
import Loader from 'react-loader-spinner'

const humanizeString = require('humanize-string');

const Authors = (props) => {
    const slug = useParams().slug
    let words = humanizeString(slug).split(" ");
    for (let i = 0; i < words.length; i++) {
        words[i] = words[i][0].toUpperCase() + words[i].substr(1);
    }
    const name = words.join(' ')
    const [books, setBooks] = useState(props.books)
    const [author, setAuthor] = useState(name)
    const [loaded, setLoaded] = useState(false)
    const [page, setPage] = useState(0)
    const [pages, setPages] = useState(1)
    const [loading, setLoading] = useState(true)


    useEffect(() => {
        setBooks(props.books)
        setPage(props.page)
        setPages(props.pages)
    }, [props.books])

    useEffect(() => {
        if (loading) {
            axios.get(`/api/v1/authors/${slug}`, {
                params: {
                    page: page + 1
                }
            })
                .then((resp) => {
                    if ((books.length === 0 || resp.data.data.attributes.books.page > page) && $('#search-field').val() === '') {
                        setBooks(resp.data.data.attributes.books.data)
                        setPage(resp.data.data.attributes.books.page)
                        setPages(resp.data.data.attributes.books.pages)
                        setLoading(false)
                    }
                    setAuthor(resp.data.data.attributes.name)
                    setLoaded(true)
                })
                .catch((resp) => {
                    console.log('Something went wrong...')
                    console.log(resp)
                })
        }
    }, [loading])
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

    const handleChange = (e, {activePage}) => {
        let gotopage = {activePage}
        let pagenum = gotopage.activePage
        setLoading(true)
        setPage(pagenum - 1)
        window.scrollTo(0, 0)
    }

    let pagination = '';
    if (pages > 1) {
        pagination = (<Pagination
            onPageChange={handleChange} siblingRange={1}
            boundaryRange={0}
            defaultActivePage={page}
            totalPages={pages}
        />)
    }
    if (loading) {
        return (
            <div className={'catalogue'}>
                <h1>Catalogue: </h1>
                <div className="grid">
                    <div className="loading"><Loader
                        type="Puff"
                        color="#00BFFF"
                        height={100}
                        width={100}
                        timeout={3000} //3 secs
                    /></div>
                </div>
            </div>
        )
    }

    return (
        <div className={'catalogue'}>
            <h1>{author}:</h1>
            <div className="grid">
                {grid}
            </div>
            {pagination}
        </div>
    )
}

export default Authors
