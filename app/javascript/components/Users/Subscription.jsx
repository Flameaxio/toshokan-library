import React, {useState, useEffect} from 'react'
import axios from "axios";
import {Link} from 'react-router-dom'

const Subscription = () =>{
    const [subscription, setSubscription] = useState({name: '', price: '', month_limit: ''})
    const [loaded, setLoaded] = useState(false)

    useEffect(() => {
        axios.get('/api/v1/users/subscription/').then(resp => {
            console.log(resp.data.data.attributes)
            setSubscription(resp.data.data.attributes)
            setLoaded(true)
        }).catch(error => {
            console.log(error)
        })
    }, [loaded])

    return (
        <div className={'subscription subscription-card'}>
            <h1>{subscription.name}</h1>
            <h2>${subscription.price}</h2>
            <h3>{`${subscription.books_bought} / ${subscription.month_limit}`}</h3>
            <Link className={'upgrade-button btn btn-success'} to={'/subscriptions'}>Upgrade</Link>
        </div>
    )
}

export default Subscription;
