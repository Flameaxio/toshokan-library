import React from 'react'
import {Route, Switch} from 'react-router-dom'
import Books from './Books/Books'
import Book from './Book/Book'
import Header from './Common/Header'

const App = () => {
    return (
        <>
            <Header/>
                <main>
                    <Switch>
                        <Route exact path='/' component={Books}/>
                        <Route exact path='/books' component={Books}/>
                        <Route exact path='/books/:slug' component={Book}/>
                        <Route exact path='/genres/:slug}'/>
                    </Switch>
                </main>
        </>
    )
};

export default App
