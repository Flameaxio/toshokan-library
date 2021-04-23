import React, {useEffect, useState} from 'react'
import axios from "axios";
import Book from "../Books/Book";
import '../Books/books.scss'
import './profile.scss'
import Subscription from "./Subscription";
import {Pagination} from "semantic-ui-react";
import Loader from 'react-loader-spinner'

const Profile = (props) => {
    const [books, setBooks] = useState(props.books)
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
            axios.get(`/api/v1/books/`, {
                params: {
                    user_id: props.user.id,
                    page: page + 1
                }
            })
                .then((resp) => {
                    console.log('sent')
                    if ((books.length === 0 || resp.data.page > page) && $('#search-field').val() === '') {
                        setBooks(resp.data.data)
                        setPage(resp.data.page - 1)
                        setPages(resp.data.pages)
                        setLoading(false)
                    }
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
        <div className={'profile-catalogue'}>
            <div className="catalogue grid-wrapper">
                <h1>My books:</h1>
                <div className="grid profile-grid">
                    {grid}
                </div>
                {pagination}
            </div>
            <div className="subscription-wrapper">
                <Subscription user={props.user}/>
            </div>
        </div>
    )
}

export default Profile