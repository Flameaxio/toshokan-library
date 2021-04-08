import React, {useState, useEffect} from 'react'
import logo from 'images/logo_transparent.png'
import {Link, useHistory} from "react-router-dom"
import './header.scss'
import './header'
import axios from "axios";


const Header = (props) => {
    let controls;
    const [query, setQuery] = useState('')
    let history = useHistory();

    if (props.loggedInStatus === 'LOGGED_IN') {
        controls = (
            <div className="controls">
                <div className="profile">
                    <i className="fas fa-user"/>
                    <p>My Profile</p>
                </div>
                <a style={{cursor: 'pointer'}} onClick={props.handleLogout} className="sign-out">
                    <i className="fas fa-sign-out-alt"/>
                    <p>Sign out</p>
                </a>
            </div>
        )
    } else {
        controls = (
            <div className="controls">
                <Link to={'/sign_in'} className="sign-in">
                    <i className="fas fa-sign-in-alt"/>
                    <p>Sign in</p>
                </Link>
                <Link to={'/sign_up'} className="sign-up">
                    <i className="fas fa-user-plus"/>
                    <p>Sign up</p>
                </Link>
            </div>
        )
    }

    const handleChange = (e) =>{
        const str = props.currentLocation
        const n = str.lastIndexOf('/');
        const value = str.substring(n + 1);
        let search_type = str.substring(1, n);
        if(search_type === '/')
            search_type = 'Book'
        const query = e.target.value
        setQuery(query)
        axios.get(`/api/v1/searches/search`,{
            params: {search_type: search_type,
                query: query,
                value: value
            }}).then((response) =>{
            props.updateBooks(response.data)
        }).catch((error) => {
            console.log(error)
        })
    }

    const handleSubmit = (e) =>{
        e.preventDefault();
        const str = props.currentLocation
        const n = str.lastIndexOf('/');
        const value = str.substring(n + 1);
        let search_type = str.substring(1, n);
        history.push('/')
        axios.get(`/api/v1/searches/search`,{
            params: {search_type: search_type,
                query: query,
                value: value
            }}).then((response) =>{
            props.updateBooks(response.data)
        }).catch((error) => {
            console.log(error)
        })
    }


    return (
        <header>
            <Link to={'/books'} className="logo-wrapper"><img src={logo} alt="#"/></Link>
            <div className="search-form">
                <form>
                    <div className="input-group mb-3">
                        <input id={'search-field'} value={query} onChange={handleChange} type="text" className="form-control" aria-label="Text input with dropdown button"/>
                        <div className="input-group-append">
                            <button onClick={handleSubmit} type={"submit"} className="btn btn-outline-secondary"><i className="fas fa-search"/></button>
                        </div>
                    </div>
                </form>
            </div>
            {controls}
        </header>
    )
}

export default Header
