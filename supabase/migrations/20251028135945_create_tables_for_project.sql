CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create schema if not already existing
CREATE SCHEMA IF NOT EXISTS branchInternational;


CREATE TABLE branchInternational.customer_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'open' CHECK (status IN ('open', 'working', 'closed')),
    urgency_score INT DEFAULT 0,
    resolved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Agents replies table
CREATE TABLE branchInternational.agents_replies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_message_id UUID REFERENCES branchInternational.customer_messages(id) ON DELETE CASCADE,
    agent_name VARCHAR(100) NOT NULL,
    reply_message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


