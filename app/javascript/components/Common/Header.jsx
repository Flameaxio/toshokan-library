import React, {useState, useEffect} from 'react'
import logo from 'images/logo_transparent.png'
import {Link} from "react-router-dom"
import './header.scss'
import './header'
import axios from "axios";


const Header = (props) => {
    let controls;
    const [searchTypes, setSearchTypes] = useState(['Books'])
    const [searchType, setSearchType] = useState(searchTypes.first)

    useEffect(() => {
        axios.get('/api/v1/searches/types').then((response) => {
            setSearchTypes(response.data)
        }).catch(error => {
            console.log(error)
        })
    }, [searchTypes.length])

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

    let dropdownMenu = searchTypes.map((item, index) => {
        if (index === 0) {
            return (
                <button key={item} className="dropdown-item active" type="button">{item}</button>
            )
        } else {
            return (
                <button key={item} className="dropdown-item" type="button">{item}</button>
            )
        }
    })

    return (
        <header>
            <Link to={'/books'} className="logo-wrapper"><img src={logo} alt="#"/></Link>
            <div className="search-form">
                <form>
                    <div className="input-group mb-3">
                        <div className="input-group-prepend">
                            <button className="btn btn-outline-secondary dropdown-toggle" type="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{searchType}
                            </button>
                            <div className="dropdown-menu">
                                {dropdownMenu}
                            </div>
                        </div>
                        <input type="text" className="form-control" aria-label="Text input with dropdown button"/>
                        <div className="input-group-append">
                            <button type={"submit"} className="btn btn-outline-secondary"><i className="fas fa-search"/></button>
                        </div>
                    </div>
                </form>
            </div>
            {controls}
        </header>
    )
}

export default Header
