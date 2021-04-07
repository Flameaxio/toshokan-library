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

export default class App extends Component {
    constructor(props) {
        super(props);

        this.state = {
            loggedInStatus: 'NOT_LOGGED_IN',
            user: {}
        }

        this.handleSuccessfulAuth = this.handleSuccessfulAuth.bind(this)
        this.handleLogin = this.handleLogin.bind(this)
        this.checkLoginStatus = this.checkLoginStatus.bind(this)
        this.handleLogout = this.handleLogout.bind(this)
    }

    checkLoginStatus() {
        axios.get('/api/v1/users/logged_in', {withCredentials: true}).then(response => {
            if(response.data.logged_in && this.state.loggedInStatus === 'NOT_LOGGED_IN'){
                this.setState({
                    loggedInStatus: 'LOGGED_IN',
                    user: response.data.user
                })
            } else if(!response.data.logged_in && this.state.loggedInStatus === 'LOGGED_IN'){
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

    handleLogout(){
        axios.delete('/api/v1/users/logout', {withCredentials: true}).then(() => {
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

    render() {
        return (
            <>
                <Header loggedInStatus={this.state.loggedInStatus} handleLogout={this.handleLogout}/>
                <main>
                    <Switch>
                        <Route exact path='/' render={props => (
                            <Books {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/books' render={props => (
                            <Books {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/books/:slug' render={props => (
                            <Book {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/genres/:slug' render={props => (
                            <Genres {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/authors/:slug' render={props => (
                            <Authors {...props} loggedInStatus={this.state.loggedInStatus}/>
                        )}/>
                        <Route exact path='/sign_up' render={props => (
                            <SignUp {...props} handleSuccessfulAuth={this.handleSuccessfulAuth}/>
                        )}/>
                        <Route exact path='/sign_in' render={props => (
                            <SignIn {...props} handleSuccessfulAuth={this.handleSuccessfulAuth}/>
                        )}/>
                    </Switch>
                </main>
            </>
        )
    }
}
