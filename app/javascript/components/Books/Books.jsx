import React, {useState, useEffect, Fragment} from 'react'
import axios from "axios";
import Book from "./Book";

const Books = () => {
    const [books, setBooks] = useState([])

    useEffect(() => {
        axios.get('/api/v1/books.json')
            .then((resp) => {
                setBooks(resp.data.data)
            })
            .catch((resp) => {
                console.log('Something went wrong...')
                console.log(resp)
            })
    }, [books.length])

    const grid = books.map( item => {
        return(
            <Book key={item.attributes.slug}
                  attributes={item.attributes}
            />
        )
    })

    return (
       <div className={'catalogue'}>
           <div className="grid">
               {grid}
           </div>
       </div>
    )
}

export default Books
