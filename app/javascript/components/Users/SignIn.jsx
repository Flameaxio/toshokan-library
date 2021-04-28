import React, {Component} from 'react';
import axios from "axios";

export default class SignIn extends Component {
    constructor(props) {
        super(props);

        this.handleSubmit = this.handleSubmit.bind(this)
        this.handleChange = this.handleChange.bind(this)

        this.state = {
            email: '',
            password: '',
            loginErrors: ''
        }
    }

    handleChange(event) {
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    handleSubmit(event) {
        event.preventDefault();
        axios.post('/api/v1/users/sessions', {
            user: {
                email: this.state.email,
                password: this.state.password
            }
        }, {withCredentials: true}).then((data) => {
            if (data.data.status === 'created')
                this.props.handleSuccessfulAuth(data.data)
            else {
                const error = data.data.error
                $('#message').html(error)
            }
        }).catch(error => {
            console.log("Login error -> ", error);
        })
    }

    render() {
        return (
            <div className={'form-wrapper'}>
                <form onSubmit={this.handleSubmit} autoComplete="new-password">
                    <h3>Sign in</h3>
                    <div style={{color: 'red'}} id="message"/>
                    <label htmlFor="email">Email:</label>
                    <input value={this.state.email}
                           onChange={this.handleChange}
                           type="email"
                           name={'email'}
                           required={true}
                           id={'email'}
                           className={'form-control'}/>
                    <label htmlFor="password">Password:</label>
                    <input value={this.state.password}
                           onChange={this.handleChange}
                           type="password"
                           name={'password'}
                           required={true}
                           id={'password'}
                           autoComplete="new-password"
                           className={'form-control'}/>
                    <button className={'btn btn-primary'} type={'submit'}>Sign in!</button>
                </form>
            </div>
        )
    }
}