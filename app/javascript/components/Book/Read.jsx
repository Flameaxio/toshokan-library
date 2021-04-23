import React, {useState, useEffect, useRef} from "react";
import axios from "axios";
import {useParams} from "react-router-dom";
import WebViewer from '@pdftron/pdfjs-express';
import './read.scss'
import Loader from 'react-loader-spinner'

function base64ToBlob(base64) {
    const binaryString = window.atob(base64);
    const len = binaryString.length;
    const bytes = new Uint8Array(len);
    for (let i = 0; i < len; ++i) {
        bytes[i] = binaryString.charCodeAt(i);
    }

    return new Blob([bytes], {type: 'application/pdf'});
};

const Read = () => {
    const [file, setFile] = useState('')
    const [loaded, setLoaded] = useState(false)
    const slug = useParams().slug;
    const viewer = useRef(null);
    useEffect(() => {
        if (!loaded) {
            axios.get(`/api/v1/books/${slug}/read`).then(resp => {
                const file = base64ToBlob(resp.data.file)
                WebViewer(
                    {
                        path: '/',
                        initialDoc: '',
                        extension: 'pdf'
                    },
                    viewer.current,
                ).then((instance) => {
                    instance.setHeaderItems(header => {
                        const items = header.getItems().slice(9, -3);
                        header.update(items);
                    });
                    instance.loadDocument(file);
                    const {docViewer} = instance;
                    docViewer.on('documentLoaded', () => {
                        setLoaded(true)
                    });
                });
            }).catch(err => {
                console.log(err)
            })
        }
    }, [loaded])

    let loading;
    if (!loaded) {
        loading =
            <div className="loading"><Loader
                type="Puff"
                color="#00BFFF"
                height={100}
                width={100}
            /></div>
    }

    return (
        <>
            {loading}
            <div className="webviewer" ref={viewer}/>
        </>
    )
}

export default Read