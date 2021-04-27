import React, {useState, useEffect} from 'react'
import axios from "axios";
import Book from "./Book";
import './books.scss'
import {Pagination} from "semantic-ui-react";
import Loader from "react-loader-spinner";

const Books = (props) => {
    const [books, setBooks] = useState([])
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
            axios.get('/api/v1/books.json', {
                params: {
                    page: page + 1
                }
            })
                .then((resp) => {
                    if ((books.length === 0 || resp.data.page > page) && $('#search-field').val() === '') {
                        setBooks(resp.data.data)
                        setPage(resp.data.page - 1)
                        setPages(resp.data.pages)
                        setLoading(false)
                    }
                })
                .catch((resp) => {
                    console.log('Something went wrong...')
                    console.log(resp)
                })
        }
    }, [loading])

    const grid = books.map(item => {
        return (
            <Book key={item.attributes.slug}
                  attributes={item.attributes}
            />
        )
    })

    const handleChange = (e, {activePage}) => {
        let gotopage = {activePage}
        let pagenum = gotopage.activePage
        setLoading(true)
        setPage(pagenum - 1)
        window.scrollTo(0, 0)
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
                    /></div>
                </div>
            </div>
        )
    }
    return (
        <div className={'catalogue'}>
            <h1>Catalogue: </h1>
            <div className="grid">
                {grid}
            </div>
            <Pagination
                onPageChange={handleChange} siblingRange={1}
                boundaryRange={0}
                defaultActivePage={page+1}
                totalPages={pages}
            />
        </div>
    )
}

export default Books
