import { Navigate, Route, Routes, useParams } from 'react-router-dom'
import LoginPage from '@/pages/LoginPage'
import LandingPage from '@/pages/LandingPage'
import ProtectedWorkspace from './ProtectedWorkspace'
import WorkspaceLayout from './WorkspaceLayout'
import { PaperAnalyzerPage } from '@/features/paper-analyzer'
import { TranslatorPage } from '@/features/translator'
import { ArchTrainerPage } from '@/features/model-review'
import { ContextorPage } from '@/features/contextor'
import { HOME_NAV } from '@/shared/navigation/workspaceNav'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<LandingPage />} />
      <Route path="/login" element={<LoginPage mode="login" />} />
      <Route path="/signup" element={<LoginPage mode="signup" />} />
      <Route path="/register" element={<Navigate to="/signup" replace />} />

      {/* /:username은 인증 확인만 담당(ProtectedWorkspace) — 화면 선택은
          WorkspaceLayout 아래 자식 라우트가 URL로 결정한다. */}
      <Route path="/:username" element={<ProtectedWorkspace />}>
        <Route element={<WorkspaceLayout />}>
          <Route index element={<Navigate to={HOME_NAV} replace />} />
          {/* 할 일(Plan)은 2026-10-11에 제거. 옛 주소로 오면 첫 화면으로 보낸다. */}
          <Route path="tasks/*" element={<GoHome />} />
          <Route path="calendar/*" element={<GoHome />} />
          <Route path="papers" element={<PaperAnalyzerPage />} />
          <Route path="translate" element={<TranslatorPage />} />
          <Route path="models" element={<ArchTrainerPage />} />
          <Route path="concepts" element={<ContextorPage />} />
        </Route>
      </Route>
    </Routes>
  )
}

function GoHome() {
  const { username = '' } = useParams()
  return <Navigate to={`/${username}/${HOME_NAV}`} replace />
}
