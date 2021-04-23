import React, {Component} from 'react'
import {Route, Switch} from 'react-router-dom'
import Books from './Books/Books'
import Book from './Book/Book'
import Header from './Common/Header'
import Genres from "./Genres/Genres";
import Authors from "./Authors/Authors";
import SignUp from './Users/SignUp'
import SignIn from "./Users/SignIn";
import axios from "axios";
import Profile from "./Users/Profile";
import Subscriptions from "./Subscriptions/Subscriptions";
import Feedback from './Common/Feedback'
import Read from "./Book/Read";

let arraysMatch = function (arr1, arr2) {

    // Check if the arrays are the same length
    if (arr1.length !== arr2.length) return false;

    // Check if all items exist and are in the same order
    for (let i = 0; i < arr1.length; i++) {
        if (arr1[i] !== arr2[i]) return false;
    }

    // Otherwise, return true
    return true;

};


function deleteAllCookies() {
    let cookies = document.cookie.split(";");

    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i];
        let eqPos = cookie.indexOf("=");
        let name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}

export default class App extends Component {
    constructor(props) {
        super(props);

        this.state = {
            loggedInStatus: 'NOT_LOGGED_IN',
            user: {},
            books: [],
            page: 0,
            pages: 1
        }

        this.handleSuccessfulAuth = this.handleSuccessfulAuth.bind(this)
        this.handleLogin = this.handleLogin.bind(this)
        this.checkLoginStatus = this.checkLoginStatus.bind(this)
        this.handleLogout = this.handleLogout.bind(this)
        this.updateBooks = this.updateBooks.bind(this)
    }

    checkLoginStatus() {
        axios.get('/api/v1/users/logged_in', {withCredentials: true}).then(response => {
            if (response.data.logged_in && this.state.loggedInStatus === 'NOT_LOGGED_IN') {
                this.setState({
                    loggedInStatus: 'LOGGED_IN',
                    user: response.data.user
                })
            } else if (!response.data.logged_in && this.state.loggedInStatus === 'LOGGED_IN') {
                this.setState({
                    loggedInStatus: 'NOT_LOGGED_IN',
                    user: {}
                })
            }
        }).catch(error => {
            console.log(error)
        })
    }

    componentDidMount() {
        this.checkLoginStatus();
    }

    handleLogout() {
        axios.delete('/api/v1/users/logout', {withCredentials: true}).then(() => {
            deleteAllCookies()
            this.setState({
                loggedInStatus: 'NOT_LOGGED_IN',
                user: {}
            })
        }).catch(error => {
            console.log(error)
        })

    }

    handleSuccessfulAuth(data) {
        this.handleLogin(data);
        this.props.history.go(-1);
    }

    handleLogin(data) {
        this.setState({
            loggedInStatus: 'LOGGED_IN',
            user: data.user
        })
    }

    updateBooks(data) {
        if (!arraysMatch(this.state.books, data.data)) {
            this.setState({
                loggedInStatus: this.state.loggedInStatus,
                user: this.state.user,
                books: data.data,
                page: data.page - 1,
                pages: data.pages
            })
        }
    }


    render() {
        let profile;
        let feedback;
        if (this.state.loggedInStatus === 'LOGGED_IN') {
            profile = <Route exact path={'/profile'} render={props => (
                <Profile {...props} user={this.state.user} books={this.state.books} page={this.state.page}
                         pages={this.state.pages}/>
            )}/>
            feedback = <Feedback user={this.state.user}/>
        }

        const full = window.location.host;
        const parts = full.split('.');
        const sub = parts[0];

        if (sub === 'admin')
            return ''

        return (
            <>
                <Header updateBooks={this.updateBooks} currentLocation={this.props.location.pathname}
                        loggedInStatus={this.state.loggedInStatus} handleLogout={this.handleLogout}
                        user={this.state.user}/>
                <main>
                    <Switch>
                        <Route exact path='/' render={props => (
                            <Books {...props} books={this.state.books} page={this.state.page} pages={this.state.pages}
                                   loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/books' render={props => (
                            <Books {...props} books={this.state.books} page={this.state.page} pages={this.state.pages}
                                   loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/books/:slug' render={props => (
                            <Book {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/genres/:slug' render={props => (
                            <Genres {...props} books={this.state.books} page={this.state.page} pages={this.state.pages}
                                    loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/authors/:slug' render={props => (
                            <Authors {...props} books={this.state.books} page={this.state.page} pages={this.state.pages}
                                     loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/books/:slug/read' render={props => (
                            <Read {...props}/>
                        )}/>
                        <Route exact path='/sign_up' render={props => (
                            <SignUp {...props} handleSuccessfulAuth={this.handleSuccessfulAuth}/>
                        )}/>
                        <Route exact path='/sign_in' render={props => (
                            <SignIn {...props} handleSuccessfulAuth={this.handleSuccessfulAuth}/>
                        )}/>
                        <Route exact path='/subscriptions' render={props => (
                            <Subscriptions {...props} />
                        )}/>
                        {profile}
                    </Switch>
                    {feedback}
                </main>
            </>
        )
    }
}
