import React from 'react'
import logo from 'images/logo_transparent.png'
import {Link} from "react-router-dom"
import './header.scss'


const Header = (props) => {
    let controls;
    if(props.loggedInStatus === 'LOGGED_IN'){
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
    }
    else{
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
            {controls}
        </header>
    )
}

export default Header
