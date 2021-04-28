import React, {Component} from 'react';
import axios from 'axios'
import './sign_up.scss'


export default class Registration extends Component {
    constructor(props) {
        super(props);

        this.handleSubmit = this.handleSubmit.bind(this)
        this.handleChange = this.handleChange.bind(this)

        this.state = {
            email: '',
            password: '',
            password_confirmation: '',
            registrationErrors: ''
        }
    }

    handleChange(event) {
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    handleSubmit(event) {
        event.preventDefault();
        if ($('#password').val() !== $('#password_confirmation').val()) {
            $('#message').html('Not Matching').css('color', 'red');
            return
        }
        axios.post('/api/v1/users/registrations', {
            user: {
                email: this.state.email,
                password: this.state.password,
                password_confirmation: this.state.password_confirmation
            }
        }, { withCredentials: true }).then((data) => {
            if(data.data.status === 'created')
                this.props.handleSuccessfulAuth(data.data)
        }).catch(error => {
            console.log("Registration error -> error", error);
        })
    }

    render() {
        return (
            <div className={'form-wrapper'}>
                <form onSubmit={this.handleSubmit} autoComplete="new-password">
                    <h3>Sign up</h3>
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
                    <label htmlFor={'password_confirmation'}>Password confirmation:</label>
                    <input value={this.state.password_confirmation}
                           onChange={this.handleChange}
                           type="password"
                           name={'password_confirmation'}
                           required={true}
                           id={'password_confirmation'}
                           className={'form-control'}/>
                    <span id='message'/>
                    <button className={'btn btn-primary'} type={'submit'}>Sign up!</button>
                </form>
            </div>
        )
    }

}