import React from 'react'
import {Route, Switch} from 'react-router-dom'
import Books from './Books/Books'
import Book from './Book/Book'
import Header from './Common/Header'
import Genres from "./Genres/Genres";
import Authors from "./Authors/Authors";

const App = () => {
    return (
        <>
            <Header/>
                <main>
                    <Switch>
                        <Route exact path='/' component={Books}/>
                        <Route exact path='/books' component={Books}/>
                        <Route exact path='/books/:slug' component={Book}/>
                        <Route exact path='/genres/:slug' component={Genres}/>
                        <Route exact path='/authors/:slug' component={Authors}/>
                    </Switch>
                </main>
        </>
    )
};

export default App
