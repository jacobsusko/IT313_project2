// Created by: David

const express = require('express');
const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const { Client } = require('pg');
const pgSession = require('connect-pg-simple')(session);

module.exports = {
    express,
    https,
    http,
    fs,
    path,
    bodyParser,
    session,
    Client,
    pgSession
};
