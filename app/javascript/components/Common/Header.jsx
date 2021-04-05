import React from 'react'
import logo from 'images/logo_transparent.png'
import {Link} from "react-router-dom"
import './header.scss'


const Header = () => {
    return (
        <header>
            <Link to={'/books'} className="logo-wrapper"><img src={logo} alt="#"/></Link>
            <div className="search-form">
                <form>
                    <div className="form-control">
                        <input placeholder={'Search...'} name={'query'} type="search"/>
                    </div>
                    <button type={'submit'}>
                        <i className="fas fa-search"/>
                    </button>
                </form>
            </div>
            <div className="controls"></div>
        </header>
    )
}

export default Header
