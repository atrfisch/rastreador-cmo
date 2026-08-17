import React, { useEffect, useMemo, useState } from 'react';
import {
  ResponsiveContainer,
  Sankey,
  Tooltip
} from 'recharts';

import {
  Activity,
  AlertTriangle,
  ArrowDownRight,
  ArrowUpRight,
  Download,
  GitCompareArrows,
  Landmark,
  RefreshCw,
  Search
} from 'lucide-react';

const brl = (numero) =>
  new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL',
    notation: 'compact',
    maximumFractionDigits: 1
  }).format(numero || 0);

const riskClass = {
  Alto: 'high',
  Médio: 'medium',
  Baixo: 'low'
};

function Kpi({
  icon: Icon,
  label,
  value,
  note,
  tone
