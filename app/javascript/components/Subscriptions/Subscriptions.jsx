import React, {useState, useEffect} from 'react'
import axios from "axios";
import './subscriptions.scss'

const Subscriptions = () => {
    const [subscriptions, setSubscriptions] = useState([])

    const handleClick = (e) => {
        const id = e.target.id
        axios.post(`/api/v1/subscribe`, null, {
            params: {
                'id': id
            }
        }).then(resp => {
            const newSubscriptions = []
            subscriptions.map((item, index) => {
                item.attributes.active = '' + index === '' + resp.data.id;
                newSubscriptions.push(item)
            })
            setSubscriptions(newSubscriptions)
        }).catch(error => {
            console.log(error)
        })
    }

    useEffect(() => {
        axios.get('/api/v1/subscriptions').then(resp => {
            setSubscriptions(resp.data.data)
        }).catch(error => {
            console.log(error)
        })
    }, [subscriptions.length])

    const subs = subscriptions.map((item, index) => {
        const subscription = item.attributes
        return (
            <div key={`subscription-${index}`} style={{width: '450px'}} className="subscription">
                <h1>{subscription.name}</h1>
                <h2>${subscription.price}/month</h2>
                <h3>{subscription.month_limit} books per month!</h3>
                <button id={`${index}`} disabled={(subscription.active)} className={`buy-subscription btn btn-success`}
                        onClick={handleClick}>{subscription.active ? 'Owned' : 'Buy'}</button>
            </div>
        )
    });

    return (
        <div className="subscriptions">
            {subs}
        </div>
    )
}

export default Subscriptions;
